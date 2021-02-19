require "CSV"

@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end
def print_footer
  puts "Overall, we have #{@students.count} great students"
end
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end
def show_students
  print_header
  print_students_list
  print_footer
end
def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end
def save_students(filename = "students.csv")
   # open the file for writing
   file = File.open(filename, "w")
   CSV.open("students.csv", "wb") do |csv|
     # iterate over the array of save_students
     @students.each do |student|
       student_data = [student[:name], student[:cohort]]
       csv << student_data
     end
   end
end
def load_students(filename = "students.csv")
  CSV.foreach(filename) do |row|
    name, cohort = row
    @students << {name: name, cohort: cohort.to_sym}
  end
end
def try_load_students
  filename = ARGV.first # first argument from the command csv_line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def interactive_menu
  loop do
    # 1. print the menu and ask the user what to do
    print_menu
    # 3. do what the user has asked
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
