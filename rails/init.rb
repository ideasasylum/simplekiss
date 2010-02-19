require 'simplekiss'

ActionView::Base.send(:include, SimpleKiss)
SimpleKiss::CONFIG = YAML.load(File.open(Rails.root+'config/kissmetrics.yml'))
