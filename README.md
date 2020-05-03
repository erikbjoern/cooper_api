# The Cooper API
* Let's users create an account and sign in
* Let's users, when signed in, make entries with their performance data from the Cooper test
* Let's users see their historical data and their performance progress

## The back-end of the Cooper application
### The API
Is the part which handles the user's two types of requests:
**User account related**, handled by Devise Token Auth
		* User registration (creating a new user account)
		* User session (signing in to an existing account)
		* User password (changing password)
		* User account removal (delete its own account)

**Performance data related**, handled by our own PerformanceDataController
		* New data entry (save new data to the  database)
		* Reading data (retrieve the user's own historical data from the database, identifying it using the user ID stored along with the performance data)

### The database
* Is PostgreSQL
* Has models for 
	* **users**, generated with Devise Token Auth
	* and **user performance data**, which holds a hash containing performance data along with the user ID of the user who saved the data.
