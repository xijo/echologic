class Question < Statement
  validates_parent :Question, :NilClass
  expects_children :Proposal
  named_scope(:roots, lambda { { :conditions => { :root_id => nil } } })
end
