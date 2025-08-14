# Data Collection API Documentation

## **1. List Scales for a Profile**

`GET /scales/{profile}`

Fetch all scales visible to a specific profile type along with completion status.

### **Request Headers**

| Key             | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <token>`   |
| `Accept`        | `application/json` |

### **URL Parameters**

| Parameter | Type   | Required | Description                                 |
| --------- | ------ | -------- | ------------------------------------------- |
| profile   | string | Yes      | Profile type (e.g., child, parent, teacher) |

### **Responses**

#### ✅ **200 OK**

```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Well-being Scale",
      "visible_to": "child",
      "totalQuestions": 10,
      "response_count": 7,
      "status": "incomplete"
    }
  ],
  "message": "fetched"
}
```

#### ❌ **500 Server Error**

```json
{
  "success": false,
  "message": "server_error",
  "data": "Error message here"
}
```

---

## **2. Get Single Scale Details**

`GET /scale/{scale_id}`

Fetch a single scale and its associated questions for the authenticated user's profile.

### **Request Headers**

| Key             | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <token>`   |
| `Accept`        | `application/json` |

### **URL Parameters**

| Parameter | Type | Required | Description     |
| --------- | ---- | -------- | --------------- |
| scale_id  | int  | Yes      | ID of the scale |

### **Responses**

#### ✅ **200 OK**

```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "Well-being Scale",
    "questions": [
      {
        "id": 101,
        "question_text": "How are you feeling today?",
        "options": [
          { "id": 1, "text": "Good" },
          { "id": 2, "text": "Okay" },
          { "id": 3, "text": "Bad" }
        ]
      }
    ]
  },
  "message": "fetched"
}
```

#### ❌ **500 Server Error**

```json
{
  "success": false,
  "message": "server_error",
  "data": "Error message here"
}
```

---

## **3. Respond to a Question**

`POST /question/respond/{question_id}`

Submit a response for a specific question in a scale.

### **Request Headers**

| Key             | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <token>`   |
| `Accept`        | `application/json` |
| `Content-Type`  | `application/json` |

### **URL Parameters**

| Parameter   | Type | Required | Description                      |
| ----------- | ---- | -------- | -------------------------------- |
| question_id | int  | Yes      | ID of the question to respond to |

### **Request Body**

```json
{
  "option_id": 2,
  "text_answer": "I feel okay.",
  "numeric_answer": 5
}
```

### **Responses**

#### ✅ **200 OK**

```json
{
  "success": true,
  "data": {
    "id": 201,
    "profile_id": 1,
    "question_id": 101,
    "option_id": 2,
    "text_answer": "I feel okay.",
    "numeric_answer": 5
  },
  "message": "created"
}
```

#### ❌ **500 Server Error**

```json
{
  "success": false,
  "message": "server_error",
  "data": "Error message here"
}
```
