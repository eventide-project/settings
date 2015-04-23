require 'pathname'
require 'telemetry/logger'
require 'attribute'
require 'dependency'; Dependency.activate
require 'json'
require 'confstruct'

require 'settings/data_source/hash'
require 'settings/data_source/file'
require 'settings/data_source/data_source'
require 'settings/registry'

require 'settings/file'

require 'settings/settings'
require 'settings/activate'
require 'settings/setting/assignment'
require 'settings/setting/macro'
