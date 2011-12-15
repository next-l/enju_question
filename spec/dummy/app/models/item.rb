# -*- encoding: utf-8 -*-
class Item < ActiveRecord::Base
  scope :on_shelf, where('shelf_id != 1')
  scope :on_web, where(:shelf_id => 1)
end
