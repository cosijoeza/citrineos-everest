echo "Setting up the server..."
echo "Soruce the .env file"
source .env

echo "Go to root directory"
cd ../

echo "Install all dependencies.."
npm run install-all

echo "Build the project.."
npm run build

echo "Go to server directory"
cd Server/

echo "Build the docker image"
docker compose -f docker-compose-v2.yml up --build -d