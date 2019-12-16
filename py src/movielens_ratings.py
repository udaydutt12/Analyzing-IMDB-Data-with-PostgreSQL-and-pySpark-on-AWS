# -*- coding: cp1252 -*-
import psycopg2
import sys, os, configparser
from pyspark import SparkConf, SparkContext

log_path = "/home/hadoop/logs/" 
aws_region = "us-east-1"  
s3_bucket = "cs327e-fall2017-final-project" 
ratings_file = "s3a://" + s3_bucket + "/movielens/ratings.csv" 
links_file = "s3a://" + s3_bucket + "/movielens/links.csv" 

# global variable sc = Spark Context
sc = SparkContext()

# global variables for RDS connection
rds_config = configparser.ConfigParser()
rds_config.read(os.path.expanduser("~/config"))
rds_database = rds_config.get("default", "database") 
rds_user = rds_config.get("default", "user")
rds_password = rds_config.get("default", "password")
rds_host = rds_config.get("default", "host")
rds_port = rds_config.get("default", "port")

def init():
    # set AWS access key and secret account key
    cred_config = configparser.ConfigParser()
    cred_config.read(os.path.expanduser("~/.aws/credentials"))
    access_id = cred_config.get("default", "aws_access_key_id") 
    access_key = cred_config.get("default", "aws_secret_access_key") 
    
    # spark and hadoop configuration
    sc.setSystemProperty("com.amazonaws.services.s3.enableV4", "true")
    hadoop_conf=sc._jsc.hadoopConfiguration()
    hadoop_conf.set("fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
    hadoop_conf.set("com.amazonaws.services.s3.enableV4", "true")
    hadoop_conf.set("fs.s3a.access.key", access_id)
    hadoop_conf.set("fs.s3a.secret.key", access_key)
    os.environ['PYSPARK_SUBMIT_ARGS'] = "--packages=org.apache.hadoop:hadoop-aws:2.7.3 pyspark-shell"

################## general utility function ##################################

def print_rdd(rdd, logfile):
  f = open(log_path + logfile, "w") 
  results = rdd.collect() 
  counter = 0
  for result in results:
    counter = counter + 1
    f.write(str(result) + "\n")
    if counter > 30:
      break
  f.close()

################## ratings file ##################################
  
def parse_line(line):
  fields = line.split(",")
  movie_id = int(fields[1])
  rating = fields[2]
  return (movie_id, rating)
 
init()
#defines a new RDD "lines" from the file "ratings_file".
lines = sc.textFile(ratings_file)
#passes the parse_line function through each element of the "lines" RDD and stores in into "rdd"
#rdd will have a tuple with movie_id and ratngs split by a comma. This is a pair, where movie_id is the key.
rdd = lines.map(parse_line) # movie_id, rating
#print_rdd(rdd, "movie_rating_pairs")


#Pass each value in the key-value pair RDD through a map function without changing the keys; this also retains the original RDD�s partitioning.
#we change each rating to store a value of 1. Now, the key-value pair looks like: movie_id,(rating,1)
rdd_pair = rdd.mapValues(lambda rating: (rating, 1)) # movie_id, (rating, 1)
#print_rdd(rdd_pair, "movie_rating_one_pairs") # print rdd

def add_ratings_by_movie(rating1, rating2):
  # rating1 = (rating, occurrence)
  # rating2 = (rating, occurrence)
  rating_sum_total = round(float(rating1[0]) + float(rating2[0]), 2)
  rating_occurrences = rating1[1] + rating2[1]
  return (rating_sum_total, rating_occurrences)

#Passes the values for each key using an associative and commutative reduce function. performs merging locally on each mapper before sending results to a reducer.
#Basically, the key stays the same and the values are reduced. Now, the new RDD looks like : movie_id, (sum of ratings, total number of ratings)
rdd_totals = rdd_pair.reduceByKey(add_ratings_by_movie) # movie_id (total rating, total occurrences)
#print_rdd(rdd_totals, "movie_total_rating_occurrences") # print rdd
  
def avg_ratings_by_movie(rating_total_occur):
  rating_total = float(rating_total_occur[0])
  rating_occur = rating_total_occur[1]
  avg_rating = round((rating_total / rating_occur), 2)
  return avg_rating

#Pass each value in the key-value pair RDD through a map function without changing the keys
#This will run the function above on the rdd_totals to obtain the 'rdd_avgs'. The new RDD looks like: movie_id, average_rating 
rdd_avgs = rdd_totals.mapValues(avg_ratings_by_movie) # movie_id, average rating
#print_rdd(rdd_avgs, "movie_rating_averages") # print rdd

#Persist this RDD with the default storage level (MEMORY_ONLY).
rdd_avgs.cache()

################## links file ##################################

def parse_links_line(line):
  fields = line.split(",")
  movie_id = int(fields[0])
  imdb_id = int(fields[1])
  return (movie_id, imdb_id)
  
# lookup imdb id
#defines a base RDD "link_lines" from the file links_file.
links_lines = sc.textFile(links_file)
#does a map transformation on links_lines,passing each element through parse_links_line and puts it in rdd_links.
# rdd_links will have a tuple with movie_id and imdb_id split by a comma. This is a pair, where movie_id is the key
rdd_links = links_lines.map(parse_links_line) # movie_id, imdb_id
#print_rdd(rdd_links, "rdd_links")


#joins are supported through leftOuterJoin, rightOuterJoin, and fullOuterJoin.
#we join the two RDD's we created. The result is: movie_id, avg_rating, imdb_id
rdd_joined = rdd_avgs.join(rdd_links)
#print_rdd(rdd_joined, "movielens_imdb_joined")

def add_imdb_id_prefix(tupl):
  movielens_id, atupl = tupl
  avg_rating, imdb_id = atupl
  imdb_id_str = str(imdb_id)
  
  if len(imdb_id_str) == 1:
     imdb_id_str = "tt000000" + imdb_id_str
  elif len(imdb_id_str) == 2:
     imdb_id_str = "tt00000" + imdb_id_str
  elif len(imdb_id_str) == 3:
     imdb_id_str = "tt0000" + imdb_id_str
  elif len(imdb_id_str) == 4:
     imdb_id_str = "tt000" + imdb_id_str
  elif len(imdb_id_str) == 5:
     imdb_id_str = "tt00" + imdb_id_str
  elif len(imdb_id_str) == 6:
     imdb_id_str = "tt0" + imdb_id_str
  else:
     imdb_id_str = "tt" + imdb_id_str
     
  return (imdb_id_str, avg_rating)

# add imdb_id prefix ()

#passes the add_imdb_id_prefix function through each element of the "rdd_joined" RDD and stores in into "rdd_ratings_by_imdb"
#This function will take the joined RDD and create a new RDD with a string version of imdb_id and avg_rating. New RDD looks like: (imdb_id_string, avg_rating)
#This is done because sometimes the same movie_id has different imdb ID's. So if we want to do analytics based on IMDB_ID, this is what we would do.
# In order to accomplish this, because our CSV files did not come with ratings paired with IMDB_ID, we first had to join with movie_ID, because movie_id was associated with the ratings.
rdd_ratings_by_imdb = rdd_joined.map(add_imdb_id_prefix) 
#print_rdd(rdd_ratings_by_imdb, "rdd_ratings_by_imdb")

def save_rating_to_db(list_of_tuples):
  conn = psycopg2.connect(database=rds_database, user=rds_user, password=rds_password, host=rds_host, port=rds_port)
  conn.autocommit = True
  cur = conn.cursor()
  
  for tupl in list_of_tuples:
    imdb_id_str, avg_rating = tupl
    
    #print "imdb_id_str = " + imdb_id_str
    #print "avg_rating = " + str(avg_rating)
    #update_stmt = "update title_ratings set movielens_rating = " + str(avg_rating) + " where title_id = '" + imdb_id_str + "'" 
    #print "update_stmt = " + update_stmt + "\n"
    update_stmt = "update title_ratings set movielens_rating = %s where title_id = %s" 

    try:
        cur.execute(update_stmt, (avg_rating, imdb_id_str))
    except Exception as e:
        print "Error in save_rating_to_db: ", e.message
  

#Applies "save_rating_to_db" to each partition of "rdd_ratings_by_imdb"
rdd_ratings_by_imdb.foreachPartition(save_rating_to_db)

# free up resources
sc.stop()
