# README

ER
``` mermaid
erDiagram
    users {
        int id PK
        string name
    }
    addresses {
        int id PK
        string postal_code
        string prefecture
        string city
        string street
        string phone_number
        int user_id FK
    }
    meals {
        int id PK
        string name
        boolean frozen
    }
    meal_sets {
        int id PK
        string name
        text description
    }
    meal_set_items {
        int id PK
        int meal_set_id FK
        int meal_id FK
        int quantity
    }
    plans {
        int id PK
        string name
        int price
        int max_meal_set_count
        text description
    }
    subscriptions {
        int id PK
        int user_id FK
        int plan_id FK
        int address_id FK
        int frequency
        date start_date
    }
    subscription_meal_sets {
        int id PK
        int subscription_id "FK meal_set_idとunique"
        int meal_set_id "FK subscription_idとunique"
    }
    deliveries {
        int id PK
        int subscription_id FK
        int address_id FK
        date delivery_date
        int time_slot "morning afternoon"
        int shipping_fee
        int frozen_fee
        int cod_fee "代金引換手数料"
        int total_price
        int status "waiting shipped received"
    }
    admins {
        int id PK
        string email
    }

    users ||--o{ addresses : has_many
    users ||--|| subscriptions : has_one
    plans ||--o{ subscriptions : "has_many"
    addresses ||--o{ subscriptions : has_many
    subscriptions ||--o{ subscription_meal_sets : has_many
    meal_sets ||--o{ subscription_meal_sets : has_many
    subscriptions ||--o{ deliveries : has_many
    addresses ||--o{ deliveries : has_many
    meal_sets ||--o{ meal_set_items : has_many
    meals ||--o{ meal_set_items : has_many

```
