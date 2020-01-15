class Mutations::CreateEmployee < Mutations::BaseMutation
  null true

  argument :name, String
  argument :age, Integer
  argument :yearly_salary, Float
  argument :work_start, String

  field :employee, Types::Employee, null: true
  field :errors, [String], null: false

  def resolve(name:, age:, yearly_salary:, work_start:)
    employee = Employee.build(name: name, age: age, work_start: work_start,
                              yearly_salary: yearly_salary)
    if employee.save
      # Successful creation, return the created object with no errors
      {
        employee: employee,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        employee: nil,
        errors: employee.errors.full_messages
      }
    end
  end
end
