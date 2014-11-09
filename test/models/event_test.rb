require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "events know their country name" do
    old_locale = I18n.locale
    I18n.locale = :de
    assert_equal events(:car_show).country_name, 'Deutschland'
    I18n.locale = old_locale
  end

  test "a new event has the right name" do
    old_locale = I18n.locale
    I18n.locale = :fr
    assert_equal Event.new(country_code: 'FR').country_name, 'France'
    I18n.locale = old_locale
  end

  test "should not save an event without a title" do
    assert_not Event.new.save
  end
  
  test "search finds events by title" do
    assert_equal Event.search('bit').size, 1
    assert_equal Event.search('bit').first, events(:cebit)
  end
  
  test "search finds events by subtitle" do
    assert_equal Event.search('super').size, 1
    assert_equal Event.search('super').first, events(:car_show)
  end
  
  test "search finds events by description" do
    assert_equal Event.search('such').size, 1
    assert_equal Event.search('such').first, events(:car_show)
  end
  
  test "event with published-date should be public?" do
    assert events(:car_show).public?
  end
  
  test "event with published-date should be public?" do
    refute events(:cebit).public?
  end
  
end
