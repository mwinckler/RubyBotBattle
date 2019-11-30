class BotFactory
  def available_bots(relative_base_dir)
    available = []
    invalid = []
    # read all available bots from ./bots directory
    # TODO: NiceToHave: Handle namespaces/subdirectories
    Dir.glob(File.join(relative_base_dir, "/bots/*.rb")).each do |f|
      require(f)
      class_name = File.basename(f, File.extname(f)).split('_').collect(&:capitalize).join
      begin
        klass = Object.const_get(class_name)

        if is_bot?(klass)
          available.push(klass)
        else
          invalid.push(class_name)
        end
      rescue NameError
        invalid.push(class_name)
      end
    end

    return {
      available: available,
      invalid: invalid
    }
  end

  private

  def is_bot?(klass)
    required_methods = [:display_name, :act]
    return required_methods.all? {|method_name| klass.method_defined?(method_name) }
  end
end