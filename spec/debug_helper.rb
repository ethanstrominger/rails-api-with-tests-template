# DebugHelper
module DebugHelper
  def quickDebug(msg)
    print Rainbow(msg)
      .white.bright.background(:red)
  end
end
