# *******************************************************************************
# Honeybee OpenStudio Gem, Copyright (c) 2020, Alliance for Sustainable
# Energy, LLC, Ladybug Tools LLC and other contributors. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# (1) Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# (2) Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# (3) Neither the name of the copyright holder nor the names of any contributors
# may be used to endorse or promote products derived from this software without
# specific prior written permission from the respective party.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) AND ANY CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER(S), ANY CONTRIBUTORS, THE
# UNITED STATES GOVERNMENT, OR THE UNITED STATES DEPARTMENT OF ENERGY, NOR ANY OF
# THEIR EMPLOYEES, BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# *******************************************************************************

require 'honeybee/material/opaque'
require 'to_openstudio/model_object'

module Honeybee
  class EnergyMaterial < ModelObject

    def self.from_material(material)
        # create an empty hash
        hash = {}
        hash[:type] = 'EnergyMaterial'
        # set hash values from OpenStudio Object
        hash[:identifier] = clean_name(material.nameString)
        unless material.displayName.empty?
          hash[:display_name] = (material.displayName.get).force_encoding("UTF-8")
        end
        hash[:thickness] = material.thickness
        hash[:conductivity] = material.conductivity
        hash[:density] = material.density
        hash[:specific_heat] = material.specificHeat
        case material.roughness.downcase
        when 'veryrough'
          hash[:roughness] == 'VeryRough'
        when 'mediumrough'
          hash[:roughness] == 'MediumRough'
        when 'mediumsmooth'
          hash[:roughness] == 'MediumSmooth'
        when 'verysmooth'
          hash[:roughness] == 'VerySmooth'
        # In case of Rough or Smooth
        else
          hash[:roughness] = material.roughness.titleize
        end
        hash[:thermal_absorptance] = material.thermalAbsorptance
        hash[:solar_absorptance] = material.solarAbsorptance
        hash[:visible_absorptance] = material.visibleAbsorptance

        hash
    end

  end # EnergyMaterial
end # Honeybee
