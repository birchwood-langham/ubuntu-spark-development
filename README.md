# Ubuntu Spark Development environment

This image builds on the ubuntu-scala docker image and adds Spark and Anaconda environment with Python 3 for Spark development.

The default entry command for this container will launch a Jupyter server running on port 8888

To create a container:

```bash
docker run -d --name <container-name> -p 8888:8888 -v <your project folder>:/home/spark/code -v <your maven repo>:/home/spark/.m2 -v <your ivy repo>:/home/spark/.ivy2 guoguojin/ubuntu-spark-development:2.1.1
```

By exposing a local folder for your project, maven and ivy, you can delete and re-create the container without losing your work, or having to re-downloading dependencies when using build tools like maven and sbt.

If you don't want to start a Jupyter server, you can also run:

```bash
docker run -it --rm --name <container-name> -v <your project folder>:/home/spark/code -v <your maven repo>:/home/spark/.m2 -v <your ivy repo>:/home/spark/.ivy2 guoguojin/ubuntu-spark-development:2.1.1 spark-shell
```

to start a Scala Spark shell, or:

```bash
docker run -it --rm --name <container-name> -p 8888:8888 -v <your project folder>:/home/spark/code -v <your maven repo>:/home/spark/.m2 -v <your ivy repo>:/home/spark/.ivy2 guoguojin/ubuntu-spark-development:2.1.1 pyspark
```

to start a Python Spark Shell.

See the [Spark website](http://spark.apache.org/) for more information about what other Spark language shells are available.

## Change Log

2017-05-11: Updated Spark and Anaconda version
2017-05-11: Changed folder for code into a subdirectory of the home directory for better organisation, and fixed the README file so that the correct docker commands are provided to launch containers
2017-10-19: Updated Anaconda version and changed version numbering
