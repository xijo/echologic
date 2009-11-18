class Question < Statement
  validates_parent :Question, :NilClass
  named_scope(:roots, lambda { { :conditions => { :root_id => nil } } })
end
