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

require 'honeybee/load/lighting'
require 'to_openstudio/model_object'

module Honeybee
    class LightingAbridged < ModelObject

        def self.from_load(load)
            # create an empty hash
            hash = {}
            hash[:type] = 'LightingAbridged'
            # set hash values from OpenStudio Object
            hash[:identifier] = clean_name(load.nameString)
            unless load.displayName.empty?
                hash[:display_name] = (load.displayName.get).force_encoding("UTF-8")
            end
            unless load.schedule.empty?
                schedule = load.schedule.get
                if schedule.to_ScheduleFixedInterval.is_initialized or schedule.to_ScheduleRuleset.is_initialized
                    hash[:schedule] = schedule.nameString
                end
            end
            loads_def = load.lightsDefinition
            unless loads_def.wattsperSpaceFloorArea.empty?
                hash[:watts_per_area] = loads_def.wattsperSpaceFloorArea.get
            end
            #TODO: user_data?
            #TODO: baseline_watts_per_area
            hash[:visible_fraction] = loads_def.fractionVisible
            hash[:radiant_fraction] = loads_def.fractionRadiant
            hash[:return_air_fraction] = loads_def.returnAirFraction

            hash
        end
    end
end
