class Question < Statement
  named_scope(:roots, lambda { { :conditions => { :root_id => nil } } })
end
