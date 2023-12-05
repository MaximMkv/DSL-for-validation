class Validator
    def initialize
      @rules = []
    end
  
    def validate(data)
      @rules.each do |rule|
        rule.call(data)
      end
    end
  
    def presence(field)
      @rules << ->(data) {
        raise "#{field} is required" unless data.key?(field) && !data[field].nil?
      }
    end
  
    def length(field, min, max)
      @rules << ->(data) {
        value = data[field]
        raise "#{field} length must be between #{min} and #{max}" unless value.nil? || (min..max).cover?(value.length)
      }
    end
  
    def email_format(field)
      @rules << ->(data) {
        value = data[field]
        email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        raise "#{field} has an invalid email format" unless value.nil? || value.match?(email_regex)
      }
    end
  
    def numerical(field)
      @rules << ->(data) {
        value = data[field]
        raise "#{field} must be a number" unless value.nil? || value.is_a?(Numeric)
      }
    end
  
    def password_complexity(field)
      @rules << ->(data) {
        value = data[field]
        raise "#{field} must contain at least one uppercase letter, one lowercase letter, and one digit" unless value.nil? || (/[A-Z]/.match?(value) && /[a-z]/.match?(value) && /\d/.match?(value))
      }
    end
  end
  
  # Приклад використання DSL для визначення правил валідації
def main()
  validator = Validator.new
  
  validator.presence(:username)
  validator.length(:password, 6, 12)
  validator.email_format(:email)
  validator.numerical(:age)
  validator.password_complexity(:password)
  
print("Enter username: ")
  username = gets()
print("Enter password: ")
  password = gets()
print("Enter email: ")
  email = gets().chomp
print("Enter age: ")
  age = gets().to_i


  data_to_validate = {username: username, password: password, email: email, age: age}

#   data_to_validate = { username: 'john_doe', password: 'Password123', email: 'john@example.com', age: 25 }

  begin
    validator.validate(data_to_validate)
    puts 'Validation successful!'
  rescue StandardError => e
    puts "Validation failed: #{e.message}"
  end
end

main
  