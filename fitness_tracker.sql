CREATE DATABASE fitness_tracker;

USE fitness_tracker;

CREATE TABLE users (
   user_id int PRIMARY KEY AUTO_INCREMENT,
   firstName varchar(255) NOT NULL,
   lastName varchar(255) NOT NULL,
   email varchar(255) NOT NULL,
   passwordHash varchar(255) NOT NULL,
   dateOfBirth date NULL,
   gender ENUM('M', 'F', 'Other') NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workouts (
   workout_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   workoutName varchar(255) NOT NULL,
   workoutDate date NOT NULL,
   workoutTime time NOT NULL,
   duration int NOT NULL,
   caloriesBurned int NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE exercises (
   exercise_id int PRIMARY KEY AUTO_INCREMENT,
   workout_id int FOREIGN KEY REFERENCES workouts(workout_id),
   exerciseName varchar(255) NOT NULL,
   numSets int NOT NULL,
   reps int NOT NULL,
   weight int NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE nutrition (
   nutrition_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   mealName varchar(255) NOT NULL,
   mealDate date NOT NULL,
   mealTime time NOT NULL,
   calories int NOT NULL,
   protein int NOT NULL,
   fats int NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE goals (
   goal_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   goalName varchar(255) NOT NULL,
   goalDate date NOT NULL,
   goalTime time NOT NULL,
   goalType ENUM('Weight Loss', 'Muscle Gain', 'Maintain Weight') NOT NULL,
   goalDescription varchar(255) NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE progress (
   progress_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   progressDate date NOT NULL,
   weight int NOT NULL,
   bodyFat int NOT NULL,
   muscleMass int NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE subscription (
   subscription_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   subscriptionName varchar(255) NOT NULL,
   subscriptionDate date NOT NULL,
   subscriptionTime time NOT NULL,
   subscriptionType ENUM('Monthly', 'Yearly') NOT NULL,
   subscriptionCost int NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE payments (
   payment_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   subscription_id int FOREIGN KEY REFERENCES subscription(subscription_id),
   paymentDate date NOT NULL,
   paymentTime time NOT NULL,
   paymentAmount int NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE messages (
   message_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   messageDate date NOT NULL,
   messageTime time NOT NULL,
   messageContent varchar(255) NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE notifications (
   notification_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   notificationDate date NOT NULL,
   notificationTime time NOT NULL,
   notificationContent varchar(255) NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE friends (
   friend_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   friendName varchar(255) NOT NULL,
   friendEmail varchar(255) NOT NULL,
   friendStatus ENUM('Pending', 'Accepted', 'Declined') NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE comments (
   comment_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   commentDate date NOT NULL,
   commentTime time NOT NULL,
   commentContent varchar(255) NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
); 

CREATE TABLE likes (
   like_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   likeDate date NOT NULL,
   likeTime time NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
); 

CREATE TABLE shares (
   share_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   shareDate date NOT NULL,
   shareTime time NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE posts (
   post_id int PRIMARY KEY AUTO_INCREMENT,
   user_id int FOREIGN KEY REFERENCES users(user_id),
   postDate date NOT NULL,
   postTime time NOT NULL,
   postContent varchar(255) NOT NULL,
   createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);


