mkdir data
mkdir data/postgresql
sudo chown -R cosi:cosi data
sudo chmod -R +777 data

sudo chmod -R 700 ./data/rabbitmq
sudo chown -R $(whoami):$(whoami) ./data/rabbitmq