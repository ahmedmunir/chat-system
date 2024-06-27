# Chat System

## Description
This is a simple chat system built with Ruby on Rails, using MySQL as the main datastore and Elasticsearch for message searching. The system allows creating applications, chats, and messages, and supports searching through messages using Elasticsearch.

## Requirements
- Docker
- Docker Compose

## Setup and Run

1. Clone the repository:
   ```sh
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Build and run the containers:
   ```sh
   docker-compose up --build
   ```

3. The application will be available at http://localhost:3000.

## API Endpoints

### Applications

* Create Application
    * Method: POST
    * URL: /applications
    * Body:
        ```json
        {
            "application": {
                "name": "My Application"
            }
        }
        ```
    * Response:
        ```json
        {
            "token": "generated-token",
            "name": "My Application"
        }
        ```
* Get Application
    * Method: GET
    * URL: /applications/:token
    * Response:
        ```json
        {
            "token": "generated-token",
            "name": "My Application"
        }
        ```

### Chats

* List Chats
    * Method: GET
    * URL: /applications/:application_token/chats
    * Response:
        ```json
        [
          {
            "number": 1,
            "messages_count": 0
          }
        ]
        ```

* Create Chat
    * Method: POST
    * URL: /applications/:application_token/chats
    * Response:
        ```json
            {
              "number": 1,
              "application_token": "application-token"
            }
        ```

### Messages

* List Messages
    * Method: GET
    * URL: /applications/:application_token/chats/:chat_number/messages
    * Response:
        ```json
        [
            {
                "id": 1,
                "chat_id": 2,
                "number": 1,
                "body": "Hello, World!",
                "created_at": "2024-06-27T20:03:22.468Z",
                "updated_at": "2024-06-27T20:03:22.468Z"
            },
            {
                "id": 2,
                "chat_id": 2,
                "number": 2,
                "body": "Hello, World!",
                "created_at": "2024-06-27T20:47:18.600Z",
                "updated_at": "2024-06-27T20:47:18.600Z"
            }
        ]
        ```

* Create Message
    * Method: POST
    * URL: /applications/:application_token/chats/:chat_number/messages
    * Body:
        ```json
        {
          "message": {
            "body": "Hello, World!"
          }
        }
        ```
    * Response:
        ```sh
        {
          "number": 1,
          "chat_number": 1,
          "application_token": "application-token"
        }
        ```

* Search Messages
    * Method: GET
    * URL: /applications/:application_token/chats/:chat_number/messages/search
    * Query Parameters:
        * query: The search term.
    * Response:
        ```json
        [
            {
                "id": 1,
                "chat_id": 2,
                "number": 1,
                "body": "Hello, World!",
                "created_at": "2024-06-27T20:03:22.468Z",
                "updated_at": "2024-06-27T20:03:22.468Z"
            },
            {
                "id": 2,
                "chat_id": 2,
                "number": 2,
                "body": "Hello, World!",
                "created_at": "2024-06-27T20:47:18.600Z",
                "updated_at": "2024-06-27T20:47:18.600Z"
            }
        ]
        ```

### Environment Variables
For demo purposes, credentials are hardcoded. For a production environment, move these to environment variables.
```sh
MYSQL_ROOT_PASSWORD: root
MYSQL_DATABASE: chat_system_development
MYSQL_USER: user
MYSQL_PASSWORD: password

ELASTICSEARCH_HOST: elasticsearch
ELASTICSEARCH_PORT: 9200

```

### Note
* Ensure Docker and Docker Compose are installed and running on your machine.

### Postman Collection
To import the Postman collection, use the following JSON:

```json
{
	"info": {
		"name": "Chat System API",
		"description": "Collection of endpoints for the Chat System API",
		"schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
	},
	"item": [
		{
			"name": "Applications",
			"item": [
				{
					"name": "Create Application",
					"request": {
						"method": "POST",
						"header": [
							{
								"key": "Content-Type",
								"value": "application/json"
							}
						],
						"body": {
							"mode": "raw",
							"raw": "{\n  \"application\": {\n    \"name\": \"My Application\"\n  }\n}"
						},
						"url": {
							"raw": "http://localhost:3000/applications",
							"protocol": "http",
							"host": [
								"localhost"
							],
							"port": "3000",
							"path": [
								"applications"
							]
						}
					},
					"response": []
				},
				{
					"name": "Get Application",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "http://localhost:3000/applications/:token",
							"protocol": "http",
							"host": [
								"localhost"
							],
							"port": "3000",
							"path": [
								"applications",
								":token"
							],
							"variable": [
								{
									"key": "token",
									"value": ""
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "Update Application",
					"request": {
						"method": "PUT",
						"header": [
							{
								"key": "Content-Type",
								"value": "application/json"
							}
						],
						"body": {
							"mode": "raw",
							"raw": "{\n  \"application\": {\n    \"name\": \"Updated Application\"\n  }\n}"
						},
						"url": {
							"raw": "http://localhost:3000/applications/:token",
							"protocol": "http",
							"host": [
								"localhost"
							],
							"port": "3000",
							"path": [
								"applications",
								":token"
							],
							"variable": [
								{
									"key": "token",
									"value": ""
								}
							]
						}
					},
					"response": []
				}
			]
		},
		{
			"name": "Chats",
			"item": [
				{
					"name": "Create Chat",
					"request": {
						"method": "POST",
						"header": [
							{
								"key": "Content-Type",
								"value": "application/json"
							}
						],
						"url": {
							"raw": "http://localhost:3000/applications/:application_token/chats",
							"protocol": "http",
							"host": [
								"localhost"
							],
							"port": "3000",
							"path": [
								"applications",
								":application_token",
								"chats"
							],
							"variable": [
								{
									"key": "application_token",
									"value": ""
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "Get Chats",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "http://localhost:3000/applications/:application_token/chats",
							"protocol": "http",
							"host": [
								"localhost"
							],
							"port": "3000",
							"path": [
								"applications",
								":application_token",
								"chats"
							],
							"variable": [
								{
									"key": "application_token",
									"value": ""
								}
							]
						}
					},
					"response": []
				}
			]
		},
		{
			"name": "Messages",
			"item": [
				{
					"name": "Create Message",
					"request": {
						"method": "POST",
						"header": [
							{
								"key": "Content-Type",
								"value": "application/json"
							}
						],
						"body": {
							"mode": "raw",
							"raw": "{\n  \"message\": {\n    \"body\": \"Hello, World!\"\n  }\n}"
						},
						"url": {
							"raw": "http://localhost:3000/applications/:application_token/chats/:chat_number/messages",
							"protocol": "http",
							"host": [
								"localhost"
							],
							"port": "3000",
							"path": [
								"applications",
								":application_token",
								"chats",
								":chat_number",
								"messages"
							],
							"variable": [
								{
									"key": "application_token",
									"value": ""
								},
								{
									"key": "chat_number",
									"value": ""
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "Get Messages",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "http://localhost:3000/applications/:application_token/chats/:chat_number/messages",
							"protocol": "http",
							"host": [
								"localhost"
							],
							"port": "3000",
							"path": [
								"applications",
								":application_token",
								"chats",
								":chat_number",
								"messages"
							],
							"variable": [
								{
									"key": "application_token",
									"value": ""
								},
								{
									"key": "chat_number",
									"value": ""
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "Search Messages",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "http://localhost:3000/applications/:application_token/chats/:chat_number/messages/search?query=",
							"protocol": "http",
							"host": [
								"localhost"
							],
							"port": "3000",
							"path": [
								"applications",
								":application_token",
								"chats",
								":chat_number",
								"messages",
								"search"
							],
							"query": [
								{
									"key": "query",
									"value": ""
								}
							],
							"variable": [
								{
									"key": "application_token",
									"value": ""
								},
								{
									"key": "chat_number",
									"value": "2"
								}
							]
						}
					},
					"response": []
				}
			]
		}
	]
}
```
