class Survey < ActiveRecord::Base
  belongs_to :user

  validates :pick, presence: true
  validates :gender, presence: true
  validates :year_of_birth, presence: true
  validates :country, presence: true
  validates :india_state, presence: true, if: :india?
  validates :ap_district, presence: true, if: :ap_state?

  def india?
    self.country == 'India'
  end

  def ap_state?
    self.india_state == 'Andhra Pradesh'
  end

  def self.overall
    out = []
    out << ['x', 'y']
    num = Survey.where(pick: 'United').count
    out << ['United', num]
    num = Survey.where(pick: 'Separate').count
    out << ['Separate', num]
    num = Survey.where(pick: 'None').count
    out << ['Does Not Matter', num]

    out
  end

  def self.gender_data(gender)
    out = []
    out << ['Male', 'Votes'] if gender == 'Male'
    out << ['Female', 'Votes'] if gender == 'Female'

    num = Survey.where(gender: gender, pick: 'United').count
    out << ['United', num]

    num = Survey.where(gender: gender, pick: 'Separate').count
    out << ['Separate', num]

    num = Survey.where(gender: gender, pick: 'None').count
    out << ['Does Not Matter', num]

    out
  end
end
