# Analytics Service 

## Getting Started

### Prerequisites

- Ensure you have [Node.js](https://nodejs.org/) installed.
- Ensure you have [Docker](https://www.docker.com/) installed.

### Run analytics service locally

1. Make sure you have a redis instance running
   1. If the redis instance is not running on localhost set the REDIS_HOST environment variable


2. Install dependencies
 ```cli
 npm install
 ```

3. Run analytics service
```cli
npm start
```

### Run analytics service and redis in docker 

```cli
docker-compose up
```
