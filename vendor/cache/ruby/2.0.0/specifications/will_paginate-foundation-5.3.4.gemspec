# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "will_paginate-foundation"
  s.version = "5.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adrian Rangel"]
  s.date = "2014-07-08"
  s.description = "This gem integrates the Foundation pagination component with the will_paginate pagination gem. Supports Rails and Sinatra"
  s.email = ["adrian.rangel@gmail.com"]
  s.homepage = "https://github.com/acrogenesis/will_paginate-foundation"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "will_paginate-foundation"
  s.rubygems_version = "2.0.15"
  s.summary = "Integrates the Foundation pagination component with will_paginate"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<will_paginate>, [">= 3.0.3"])
    else
      s.add_dependency(%q<will_paginate>, [">= 3.0.3"])
    end
  else
    s.add_dependency(%q<will_paginate>, [">= 3.0.3"])
  end
end
