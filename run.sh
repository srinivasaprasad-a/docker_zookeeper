echo "start zookeeper container..."
sudo docker rm -f zookeeper-host &> /dev/null
sudo docker run -itd \
		-p 2181:2181 \
                --name zookeeper-host \
                --hostname zookeeper-host \
		docker_zookeeper:latest &> /dev/null
echo "done."

