FROM birchwoodlangham/ubuntu-scala:2.12.3

ENV ANACONDA_PATH=/usr/local/anaconda

RUN groupadd -g 1000 spark && \
    useradd -u 1000 -g 1000 -m -d /home/spark spark && \
    mkdir -p /opt/apps && \
    wget https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh && \
    wget https://d3kbcqa49mib13.cloudfront.net/spark-2.2.0-bin-hadoop2.7.tgz && \
    tar -C /opt/apps -zxf spark-2.2.0-bin-hadoop2.7.tgz && \
    chown -R spark:spark /opt/apps/spark-2.2.0-bin-hadoop2.7 && \
    ln -s /opt/apps/spark-2.2.0-bin-hadoop2.7 /usr/local/spark && \
    bash Anaconda3-4.4.0-Linux-x86_64.sh -b -p $ANACONDA_PATH && \
    rm Anaconda3-4.4.0-Linux-x86_64.sh spark-2.2.0-bin-hadoop2.7.tgz && \
    $ANACONDA_PATH/bin/pip install --upgrade pip && \
    $ANACONDA_PATH/bin/pip install py4j && \
    $ANACONDA_PATH/bin/conda install jupyter -y --quiet

USER spark
WORKDIR /home/spark

# Use this one to install the plugins etc.
COPY vimrc_plugins /home/spark/.vimrc

# Now for vim plugins, the powerline fonts and nerd fonts required for powerline
RUN git clone https://github.com/powerline/fonts.git && \
    fonts/install.sh && \
    rm -rf fonts && \
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git fonts && \
    cd /home/spark/fonts && \
    ./install.sh -q --copy --complete && \
    cd /home/spark && \
    rm -rf fonts && \
    mkdir -p /home/spark/.vim && \
    git clone https://github.com/VundleVim/Vundle.vim.git /home/spark/.vim/bundle/Vundle.vim && \
    vim +PluginInstall +qall

# copy configuration files for vim, zsh and tmux
COPY vimrc /home/spark/.vimrc

VOLUME ["/home/spark/code", "/home/spark/.m2", "/home/spark/.ivy2"]

EXPOSE 8888 8080 8081 7077

ENV SPARK_HOME=/usr/local/spark
ENV PATH=$PATH:$ANACONDA_PATH/bin:$SPARK_HOME/bin \
    PYTHONPATH=$PYTHONPATH:$SPARK_HOME/python \
    JAVA_HOME=/usr/lib/jvm/java-8-oracle \
    DERBY_HOME=/usr/lib/jvm/java-8-oracle/db \
    SCALA_HOME=/usr/share/scala \
    SBT_HOME=/usr/share/sbt-launcher-packaging

CMD ["jupyter", "notebook", "--notebook-dir=/home/spark/code", "--ip='*'", "--port=8888", "--no-browser"]
