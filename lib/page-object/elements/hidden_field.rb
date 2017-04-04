module PageObject
  module Elements
    class HiddenField < Element

      def click
        raise "click is not available on the hidden field element"
      end

    end

    ::PageObject::Elements.type_to_class[:hidden] = ::PageObject::Elements::HiddenField
  end
end
