# User Profile API Documentation

## **1. Get User**

`GET /user`

Fetch the authenticated user's information along with associated profiles.

### **Request Headers**

| Key             | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <token>`   |
| `Accept`        | `application/json` |

### **Responses**

#### ✅ **200 OK**

```json
{
  "success": true,
  "data": {
    "id": 1,
    "phone_number": "017XXXXXXXX",
    "name": "John Doe",
    "profiles": [
      {
        "id": 1,
        "full_name": "Child Name",
        "type": "child",
        "relation_type": "child",
        "demography": {
          "dob": "2010-01-01",
          "gender": "male",
          "grade": "5"
        }
      }
    ]
  },
  "message": "fetched"
}
```

#### ❌ **404 User Not Found**

```json
{
  "success": false,
  "message": "not_found",
  "data": "User not found."
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

## **2. Create Profile**

`POST /profile/create`

Create a new profile for the authenticated user.

### **Request Headers**

| Key             | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <token>`   |
| `Accept`        | `application/json` |
| `Content-Type`  | `application/json` |

### **Request Body**

```json
{
  "fullName": "Jane Doe",
  "type": "child",
  "relationType": "child",
  "dob": "2010-01-01",
  "gender": "female",
  "grade": "5"
}
```

#### **Parameters**

| Field        | Type   | Required | Validation                                    | Description                            |
| ------------ | ------ | -------- | --------------------------------------------- | -------------------------------------- |
| fullName     | string | Yes      | `required`                                    | Full name of the profile.              |
| type         | string | Yes      | `required`, `in:child,parent,teacher`         | Type of profile.                       |
| relationType | string | Yes      | `required`, `in:child,father,mother,guardian` | Relation to the user.                  |
| dob          | date   | Yes      | `required`, `date`                            | Date of birth of the profile.          |
| gender       | string | Yes      | `required`, `in:male,female,other`            | Gender of the profile.                 |
| grade        | string | Yes      | `required`                                    | School grade or level (if applicable). |

### **Responses**

#### ✅ **200 OK**

```json
{
  "success": true,
  "data": {
    "id": 1,
    "full_name": "Jane Doe",
    "type": "child",
    "relation_type": "child",
    "demography": {
      "dob": "2010-01-01",
      "gender": "female",
      "grade": "5"
    }
  },
  "message": "created"
}
```

#### ❌ **401 Validation Error**

```json
{
  "success": false,
  "message": "validation_error",
  "data": {
    "fullName": ["The full name field is required."]
  }
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

## **3. Complete Onboard**

`POST /user/onboard`

Mark the user as onboarded if both child and parent profiles exist.

### **Request Headers**

| Key             | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <token>`   |
| `Accept`        | `application/json` |

### **Responses**

#### ✅ **200 OK**

```json
{
  "success": true,
  "data": "User has been successfully onboarded!",
  "message": "onboarded"
}
```

#### ❌ **406 Cannot Onboard**

```json
{
  "success": false,
  "message": "cannot_onboard",
  "data": "No child profile on this user."
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
