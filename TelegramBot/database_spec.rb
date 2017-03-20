require_relative 'database.rb'
require 'base64'
require 'rspec'

encoded = Base64.encode64(dbconnectday("ПІ-31", "Monday"))
describe do
  context "Функція dbconnectday" do
    it "Повертає\n
    TW9uZGF5CgpbMiwg0KHQuNGB0YLQtdC80Lgg0YjRgtGD0YfQvdC+0LPQviDR
    ltC90YLQtdC70LXQutGC0YMsINC70LDQsS4sINCT0YDQuNGG0Y7QuiDQri7Q
    hi4sIDUg0LrQvtGA0L/Rg9GBLT44MDgsIDEwOjIwLTExOjU1XQpbMywg0JTQ
    vtGB0LvRltC00LbQtdC90L3RjyDQvtC/0LXRgNCw0YbRltC5LCDQu9Cw0LEu
    LCDQltGD0YDQsNCy0YfQsNC6INCbLtCcLiwgMjkg0LrQvtGA0L/Rg9GBLT4z
    MDIsIDEyOjEwLTEzOjQ1XQpbNCwg0JTQvtGB0LvRltC00LbQtdC90L3RjyDQ
    vtC/0LXRgNCw0YbRltC5LCDQu9C10LouLCDQltGD0YDQsNCy0YfQsNC6INCb
    1LtCcLiwgMSDQutC+0YDQv9GD0YEtPjMyMSwgMTQ6MTUtMTU6NTBdCg==" do
    expect(Base64.encode64(dbconnectday("ПІ-31", "Monday"))).to eq encoded
  end
end
end
