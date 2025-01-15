module Legacy
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true

    connects_to database: { reading: :odkaz_pre_starostu }

    def self.default_role
      :reading
    end

    def readonly?
      true
    end
  end
end
