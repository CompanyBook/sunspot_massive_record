class PersonSearchable < MassiveRecord::ORM::Table
  column_family :info do
    field :name
    field :free_text
    field :age, :integer

    field :not_stored
  end


  searchable do
    string :name, :stored => true
    text :free_text, :stored => true
    integer :age, :stored => true
  end


  private

  def default_id
    next_id
  end
end
