class Person < MassiveRecord::ORM::Table
  column_family :info do
    field :name
    field :email
  end
end
