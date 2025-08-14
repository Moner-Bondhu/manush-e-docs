# Authentication API Documentation

## **1. Generate OTP**

`POST /login`

Generate a One-Time Password (OTP) for a given phone number.
If the user does not exist, a new account will be created automatically.

### **Request Headers**

| Key            | Value              |
| -------------- | ------------------ |
| `Content-Type` | `application/json` |
| `Accept`       | `application/json` |

### **Request Body**

```json
{
  "phoneNumber": "017XXXXXXXX"
}
```

#### **Parameters**

| Field       | Type   | Required | Validation          | Description                                                                                         |
| ----------- | ------ | -------- | ------------------- | --------------------------------------------------------------------------------------------------- |
| phoneNumber | string | Yes      | `required`, `phone` | Phone number in local format (10–11 digits). If 10 digits are given, `0` is prefixed automatically. |

---

### **Responses**

#### ✅ **200 OK**

```json
{
  "success": true,
  "data": "OTP generated message here",
  "message": "generated"
}
```

#### ❌ **401 Validation Error**

```json
{
  "success": false,
  "message": "validation_error",
  "data": {
    "phoneNumber": ["The phone number field is required."]
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

## **2. Login with OTP**

`POST /otp`

Authenticate a user using the OTP sent to their phone number.

### **Request Headers**

| Key            | Value              |
| -------------- | ------------------ |
| `Content-Type` | `application/json` |
| `Accept`       | `application/json` |

### **Request Body**

```json
{
  "phoneNumber": "017XXXXXXXX",
  "otp": 1234
}
```

#### **Parameters**

| Field       | Type    | Required | Validation                        | Description                                                                                         |
| ----------- | ------- | -------- | --------------------------------- | --------------------------------------------------------------------------------------------------- |
| phoneNumber | string  | Yes      | `required`, `phone`               | Phone number in local format (10–11 digits). If 10 digits are given, `0` is prefixed automatically. |
| otp         | integer | Yes      | `required`, `integer`, `digits:4` | 4-digit OTP received by the user.                                                                   |

---

### **Responses**

#### ✅ **200 OK**

```json
{
  "success": true,
  "data": {
    "token": "personal-access-token-here",
    "user": {
      "id": 1,
      "phone_number": "017XXXXXXXX",
      "name": "John Doe"
    }
  },
  "message": "authenticated"
}
```

#### ❌ **401 Wrong OTP**

```json
{
  "success": false,
  "message": "authentication_error",
  "data": "Wrong OTP. Attempts left: 2"
}
```

#### ❌ **401 Expired OTP**

```json
{
  "success": false,
  "message": "authentication_error",
  "data": "Your OTP has expired."
}
```

#### ❌ **404 User Not Found**

```json
{
  "success": false,
  "message": "authentication_error",
  "data": "Authentication failed."
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

### **Notes**

- **OTP Expiration**: OTP is valid for a limited time (implementation-defined).
- **Attempts**: Wrong OTP attempts decrease `attempts_left`. If it reaches 0, OTP becomes invalid.
- **Token**: Returned token should be used as `Bearer` token for authenticated API calls.
