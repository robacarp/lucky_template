module Featurette
  class DisabledFeatureError < Exception
  end

  module ActionHelpers
    macro ensure_feature_permitted(name)
      before _ensure_feature_{{ name.id }}

      def _ensure_feature_{{ name.id }}
        feature_name = "{{ name.id }}"

        if user_can? current_user, feature_name
          continue
        else
          raise Featurette::DisabledFeatureError.new("#{current_user.id} cannot '#{feature_name}'")
        end
      end
    end

    macro allow_feature_bypass(name)
      skip _ensure_feature_{{ name.id }}
    end

    @features : Hash(String, Feature?)?
    @[AlwaysInline]
    def user_can?(user : User, feature_name : Symbol) : Bool
      user_can? user, feature_name.to_s
    end

    def user_can?(user : User, feature_name : String) : Bool
      features_lookup = @features ||= Hash(String, Feature?).new do |hash, key|
        hash[key] = query_for_feature key
      end

      feature = features_lookup[feature_name]
      return false unless feature
      return true if feature.state == Feature::State::Enabled
      return false if feature.state == Feature::State::Disabled
      return user.features.map(&.name).includes? feature_name
    end

    def query_for_feature(feature_name : String) : Feature?
      FeatureQuery.new.name(feature_name).first
    end
  end
end
