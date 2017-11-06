class Reservation < ApplicationRecord
  
  validates :name, 
    presence: {message: 'Zostaw coś po sobie, najlepiej imię, telefon, rodzaj i kolor autka :)'}
  validate :name_from_to_validator
   
  def name_from_to_validator
    if to < from
     errors.add(:to, 'Ucieszmy nasz formularz i zadbajmy o logiczny porządek dat :)')
    else
      reserved_amount=0
      user_already_reserved=false
      Reservation.all.each do |el|
        reserved_amount += 1 if (el.from..el.to).overlaps?(from..to)
        user_already_reserved=true if (el.name==name) && (el.from..el.to).overlaps?(from..to)
      end
      if from < Date.today
        errors.add(:from, 'Historię zostawmy historykom :)')
      elsif reserved_amount>5
        errors.add(:from, 'W wybranym terminie parking niestety jest już zajęty :(')
      elsif user_already_reserved
        errors.add(:from, 'Ten użytkownik ma już rezerwację w tym terminie')
      end
    end
  end
end
