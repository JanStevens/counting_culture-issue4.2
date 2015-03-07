module ThisBreaksIt

  def self.included(base)
    base.after_commit :_after_commit_hook
  end

  def _after_commit_hook
  end

end

::ActiveRecord::Base.send :include, ThisBreaksIt
