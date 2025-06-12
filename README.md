# README

ER
``` mermaid
erDiagram
    %% --------------------------------------------------------
    %% Entity-Relationship Diagram
    %% --------------------------------------------------------

    %% table name: addresses
    Address{
        integer id PK
        integer user_id FK
        string postal_code
        string prefecture
        string city
        string street
        string phone_number
        datetime created_at
        datetime updated_at
    }

    %% table name: admins
    Admin{
        integer id PK
        string email
        string encrypted_password
        datetime remember_created_at
        datetime created_at
        datetime updated_at
    }

    %% table name: deliveries
    Delivery{
        integer id PK
        integer subscription_id FK
        date delivery_date
        integer time_slot
        integer status
        text delivery_memo
        integer total_price
        integer total_price_with_tax
        datetime created_at
        datetime updated_at
        integer address_id FK
        integer shipping_fee
        integer frozen_fee
        integer cod_fee
        integer schedule_fee
    }

    %% table name: delivery_meal_sets
    DeliveryMealSet{
        integer id PK
        integer delivery_id FK
        integer meal_set_id FK
        datetime created_at
        datetime updated_at
        integer quantity
    }

    %% table name: meals
    Meal{
        integer id PK
        string name
        boolean refrigeration
        datetime created_at
        datetime updated_at
    }

    %% table name: meal_sets
    MealSet{
        integer id PK
        string name
        datetime created_at
        datetime updated_at
        text description
    }

    %% table name: meal_set_items
    MealSetItem{
        integer id PK
        integer meal_set_id FK
        integer meal_id FK
        integer quantity
        datetime created_at
        datetime updated_at
    }

    %% table name: plans
    Plan{
        integer id PK
        string name
        integer price
        integer meal_sets_count
        datetime created_at
        datetime updated_at
    }

    %% table name: subscriptions
    Subscription{
        integer id PK
        integer user_id FK
        integer plan_id FK
        integer frequency
        boolean active
        datetime paused_at
        datetime created_at
        datetime updated_at
    }

    %% table name: users
    User{
        integer id PK
        string name
        string email
        string encrypted_password
        string reset_password_token
        datetime reset_password_sent_at
        datetime remember_created_at
        datetime created_at
        datetime updated_at
        string phone_number
        text allergy_notes
        boolean suspended
    }

    Address }o--|| User : "BT:user, HM:addresses"
    Delivery ||--o{ DeliveryMealSet : "HM:delivery_meal_sets, BT:delivery"
    Delivery }o..o{ MealSet : "HMT:meal_sets, HMT:deliveries"
    Delivery }o--|| Subscription : "BT:subscription, HM:deliveries"
    Delivery }o--|| Address : "BT:address"
    DeliveryMealSet }o--|| MealSet : "BT:meal_set, HM:delivery_meal_sets"
    Meal ||--o{ MealSetItem : "HM:meal_set_items, BT:meal"
    MealSet ||--o{ MealSetItem : "HM:meal_set_items, BT:meal_set"
    MealSet }o..o{ Meal : "HMT:meals"
    Plan ||--o{ Subscription : "HM:subscriptions, BT:plan"
    Subscription |o--|| User : "BT:user, HO:subscription"
```
