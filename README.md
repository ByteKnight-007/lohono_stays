# Lohono Stays API

This is a Ruby on Rails API-based project for villa booking. The API provides villa availability, sorting options, and price calculation, including GST.

## Setup Instructions

### Prerequisites
Ensure you have the following installed:
- Ruby `3.1.4`
- Rails `7.2.2.1`
- SQLite3
- Bundler
- Git

### Installation Steps
1. Clone the repository:
   ```sh
   git clone https://github.com/ByteKnight-007/lohono_stays.git
   cd lohono_stays
   ```

2. Install dependencies:
   ```sh
   bundle install
   ```

3. Set up the database:
   ```sh
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the Rails server:
   ```sh
   rails s
   ```
   The server will run on `http://localhost:3000`.

## API Endpoints

### 1. Get Available Villas
   **Endpoint:** `GET /villas/index`
   **Query Parameters:**
   - `start_date`: Booking start date (YYYY-MM-DD)
   - `end_date`: Booking end date (YYYY-MM-DD)
   - `sort`: (Optional) `price` or `availability`
   **Response:** List of available villas.

### 2. Get Villa Details and Pricing
   **Endpoint:** `GET /villas/show/:id`
   **Query Parameters:**
   - `start_date`: Booking start date (YYYY-MM-DD)
   - `end_date`: Booking end date (YYYY-MM-DD)
   **Response:**
   - `available`: true/false
   - `actual_price`: Total price before GST
   - `gst`: GST amount (18%)
   - `total_price`: Final price after GST

## Project Structure
- `app/controllers/villas_controller.rb` - Handles villa-related API requests.
- `app/services/price_calculator.rb` - Service to calculate pricing and GST.
- `app/models/villa.rb` - Villa model with availability scope.
- `db/schema.rb` - Database schema.
- `config/routes.rb` - API routes.
