class Reservation < ApplicationRecord
  
  validates :name, 
    presence: {message: 'Zostaw coś po sobie, najlepiej imię, telefon, rodzaj i kolor autka :)'},
    uniqueness: {message: 'Taka rezerwacja już istnieje'}
  validate :from_to_validator
   
  def from_to_validator
    if to < from
     errors.add(:to, 'Ucieszmy nasz formularz i zadbajmy o logiczny porządek dat :)')
    else
      reserved=0
      Reservation.all.each do |el|
        reserved += 1 if (el.from..el.to).overlaps?(from..to)
      end
      if from < Date.today
        errors.add(:from, 'Historię zostawmy historykom :)')
      elsif reserved>5
        errors.add(:from, 'W wybranym terminie parking niestety jest już zajęty :(')
      end
    end
  end
end
