# Docker LAMPN (Linux, Apache, MySQL, PHP, Node.js)

Docker LAMPN is a Dockerized image that provides a complete development environment with Linux, Apache, MySQL, PHP, and Node.js. This image is designed to facilitate web application development and testing using these technologies. (It's just my simplification purposes because, as you know, Docker is not intended for installing all of these in one container.)

## Features

- **Linux**: Ubuntu as the base operating system.
- **Apache**: A robust web server for serving web applications.
- **MySQL**: A reliable and scalable relational database management system.
- **PHP**: A popular server-side scripting language for web development.
- **Node.js**: A JavaScript runtime built on Chrome's V8 JavaScript engine, enabling server-side JavaScript execution.

## Prerequisites

- Docker installed on your machine. You can download it from [Docker's official website](https://www.docker.com/get-started).

## Getting Started

### Building the Docker Image

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/CreatorB/docker-LAMPN.git
   cd docker-LAMPN
   ```

2. Build the Docker image:
   ```bash
   docker build -t lampn .
   ```

### Running the Docker Container

1. Run the Docker container with the following command:
   ```bash
   docker run -d -p 8001:8000 -p 8003:80 -p 8005:3306 -v /your-project-path:/var/www/html --name your_project_name lampn
   ```

   - `-d`: Run the container in detached mode.
   - `-p 8001:8000`: Map port 8001 on the host to port 8000 in the container.
   - `-p 8003:80`: Map port 8003 on the host to port 80 in the container.
   - `-p 8005:3306`: Map port 8005 on the host to port 3306 in the container.
   - `-v /your-project-path:/var/www/html`: Mount the local directory `/your-project-path` to `/var/www/html` in the container.
   - `--name your_project_name`: Container name.

2. Access the web application by navigating to `http://localhost:8003` in your web browser.

### Accessing MySQL

- You can access the MySQL database from the host machine using port `8005`.
- Default credentials:
  - Username: `root`
  - Password: (empty)

### Running Laravel Commands

1. Access the container's shell:
   ```bash
   docker exec -it your_project_name /bin/bash
   ```

2. Run Laravel commands, for example:
   ```bash
   php artisan serve --host=0.0.0.0
   ```

## Configuration

### Apache Configuration

- The Apache configuration file is located at `/etc/apache2/sites-available/000-default.conf`.
- The default configuration serves the web application from `/var/www/html`.

### MySQL Configuration

- The MySQL configuration file is located at `/etc/mysql/my.cnf`.
- The default configuration allows remote access to the MySQL server.

## Example

For example, if you want to run the Tallstack Employees project: [Tallstack Employees](https://github.com/prettyblueberry/tallstack-employees).

```bash
git clone https://github.com/prettyblueberry/tallstack-employees.git

docker run -d -p 8001:8000 -p 8003:80 -p 8005:3306 -v /home/creatorbe/tallstack-employees:/var/www/html --name tallstack_employees lampn

docker exec -it tallstack_employees /bin/bash

composer install

npm install

cp .env.example .env

php artisan key:generate

php artisan migrate --seed

php artisan serve --host=0.0.0.0

npm run dev
```

The development server starts on `http://localhost:8000` inside the Docker container, and you can access it on your host machine at `http://localhost:8001` (default Docker localhost on the host machine is `http://localhost:8003`).

## F.A.Q

1. **Q**: Laravel & Docker: The stream or file "/var/www/html/storage/logs/laravel.log" could not be opened: failed to open stream: Permission denied  
   **A**: Run the following command to change permissions:
   ```bash
   chmod -R o+w ./storage/
   ```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you encounter any problems or have suggestions for improvements.

## License

This project is licensed under the MIT License.
