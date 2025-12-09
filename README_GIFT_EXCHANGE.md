# 🎄 Festive Office Gift Exchange Application

A Ruby on Rails web application designed to facilitate a multi-day office gift exchange event with three themed days: Handmade Santa, Funny Santa, and Secret Santa.

## 📋 Features

### 1. User Authentication
- **Sign Up/Sign In**: Secure user registration and login using Devise
- **Username Support**: Users can create unique usernames
- **Profile Management**: Users can update their preferences and interests

### 2. Event Management
Three themed gift exchange events:

#### 🎨 Handmade Santa (December 18th)
- Gift something handmade
- No budget constraint
- Open participation

#### 😄 Funny Santa (December 19th)
- Gift something humorous or silly
- Budget: Rs 100
- Open participation

#### 🎅 Secret Santa (December 22nd)
- Random assignment system with spin wheel animation
- Budget: Rs 300
- View assigned person's preferences
- Keep assignment secret until reveal day

### 3. Interactive Features
- **Spin Wheel Animation**: Engaging wheel spin to randomly assign Secret Santa recipients
- **Date-Based Reminders**: Automatic reminders displayed on respective event dates
- **Preference Sharing**: Users can share their interests to help Secret Santas choose gifts
- **Responsive Design**: Works seamlessly on mobile and desktop devices

## 🚀 Technology Stack

- **Framework**: Ruby on Rails 7.0.10
- **Ruby Version**: 3.2.0
- **Database**: MySQL
- **Authentication**: Devise
- **Frontend**: 
  - HTML/ERB
  - CSS3 (Custom responsive styling)
  - JavaScript (Stimulus)
  - Hotwire (Turbo & Stimulus)
- **Asset Pipeline**: Sprockets

## 📦 Installation

### Prerequisites
- Ruby 3.2.0
- Rails 7.0.10
- MySQL
- Node.js (for JavaScript dependencies)

### Setup Steps

1. **Clone or navigate to the project directory**
   ```bash
   cd /home/siddesh/Desktop/gift_exchange
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Configure database**
   - Update `config/database.yml` with your MySQL credentials if needed
   - The default configuration uses:
     - Database: `gift_exchange`
     - Username: `root`
     - Password: (as configured in your system)

4. **Create and setup database**
   ```bash
   rails db:create
   rails db:migrate
   ```

5. **Start the server**
   ```bash
   rails server
   ```

6. **Access the application**
   - Open your browser and navigate to: `http://localhost:3000`

## 📁 Project Structure

```
gift_exchange/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   ├── home_controller.rb          # Event cards & reminders
│   │   ├── profile_controller.rb       # User profile management
│   │   └── spin_controller.rb          # Secret Santa assignment
│   ├── models/
│   │   ├── user.rb                     # User model with Devise
│   │   └── assignment.rb               # Secret Santa assignments
│   ├── views/
│   │   ├── home/
│   │   │   └── index.html.erb          # Main dashboard
│   │   ├── profile/
│   │   │   └── edit.html.erb           # Profile editing
│   │   ├── spin/
│   │   │   ├── index.html.erb          # Spin wheel page
│   │   │   └── result.html.erb         # Assignment result
│   │   ├── devise/                     # Authentication views
│   │   └── layouts/
│   │       └── application.html.erb    # Main layout with nav
│   ├── assets/
│   │   └── stylesheets/
│   │       └── application.css         # Comprehensive styling
│   └── javascript/
│       └── controllers/
│           └── spin_controller.js      # Spin wheel animation
├── config/
│   ├── routes.rb                       # Application routes
│   └── database.yml                    # Database configuration
└── db/
    ├── migrate/                        # Database migrations
    └── schema.rb                       # Database schema
```

## 🎯 Usage Guide

### For Participants

1. **Sign Up**
   - Navigate to the homepage
   - Click "Sign Up"
   - Enter username, email, and password
   - Submit the form

2. **Update Profile**
   - After signing in, click "My Profile"
   - Add your username (if not set during signup)
   - Share your preferences and interests
   - Save your profile

3. **View Events**
   - The homepage displays all three event cards
   - Each card shows:
     - Event name and icon
     - Date
     - Description
     - Budget limit
     - Action button (for Secret Santa)

4. **Secret Santa Assignment**
   - Click "Spin the Wheel!" on the Secret Santa card
   - Watch the animated wheel spin
   - View your assigned person and their preferences
   - Remember to keep it secret!

5. **View Your Assignment**
   - Click "View Your Assignment" to see who you're gifting to
   - Review their preferences
   - Plan your gift within the Rs 300 budget

### For Administrators

- Monitor user registrations through Rails console
- Check assignment status in the database
- Ensure all users have updated their preferences

## 🎨 Design Features

### Responsive Design
- **Mobile-First Approach**: Optimized for mobile devices
- **Breakpoints**:
  - Mobile: < 480px
  - Tablet: 481px - 768px
  - Desktop: > 768px

### Color Scheme
- **Primary (Red)**: #c41e3a - Christmas red
- **Secondary (Green)**: #165b33 - Festive green
- **Accent (Gold)**: #f4c430 - Holiday gold
- **Background**: Gradient from light blue to soft gray

### Animations
- Smooth page transitions
- Spin wheel rotation with easing
- Hover effects on cards and buttons
- Slide-in animations for reminders

## 🔒 Security Features

- Password encryption using Devise
- CSRF protection
- Secure session management
- SQL injection prevention through ActiveRecord
- XSS protection in views

## 📊 Database Schema

### Users Table
- `id`: Primary key
- `email`: String (unique, required)
- `username`: String (unique, required)
- `encrypted_password`: String
- `preferences`: Text
- `created_at`: DateTime
- `updated_at`: DateTime

### Assignments Table
- `id`: Primary key
- `user_id`: Foreign key (giver)
- `assigned_to_id`: Foreign key (receiver)
- `event_type`: String (default: 'secret_santa')
- `revealed`: Boolean (default: false)
- `created_at`: DateTime
- `updated_at`: DateTime

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Check MySQL is running: `sudo service mysql status`
   - Verify credentials in `config/database.yml`
   - Ensure database exists: `rails db:create`

2. **Asset Loading Issues**
   - Clear cache: `rails tmp:clear`
   - Restart server

3. **Devise Routes Not Working**
   - Ensure Devise is properly installed
   - Check `config/routes.rb` has `devise_for :users`

4. **Spin Wheel Not Animating**
   - Check browser console for JavaScript errors
   - Ensure Stimulus is properly loaded
   - Verify `spin_controller.js` is in the correct location

## 🔄 Future Enhancements

- Email notifications for assignments
- Gift tracking system
- Photo upload for gifts
- Admin dashboard
- Event history
- Gift wish lists
- Anonymous messaging between Secret Santas
- Mobile app version

## 📝 License

This project is created for educational and office use purposes.

## 👥 Support

For issues or questions:
1. Check the troubleshooting section
2. Review the Rails logs: `tail -f log/development.log`
3. Check the browser console for JavaScript errors

## 🎉 Enjoy the Gift Exchange!

Have fun spreading holiday cheer with your colleagues! Remember:
- Be thoughtful with your gifts
- Respect the budget limits
- Keep Secret Santa assignments confidential
- Participate in all three events for maximum fun!

---

**Happy Holidays! 🎄🎅🎁**
