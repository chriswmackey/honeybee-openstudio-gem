# *******************************************************************************
# Ladybug Tools Energy Model Schema, Copyright (c) 2019, Alliance for Sustainable
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

require 'ladybug/energy_model/model_object'

require 'json-schema'
require 'json'
require 'openstudio'

module Ladybug
  module EnergyModel
    class EnergyWindowMaterialGas < ModelObject
      attr_reader :errors, :warnings

      def initialize(hash = {})
        super(hash)
      end

      def defaults
        result = {}
        result[:type] = @@schema[:definitions][:EnergyWindowMaterialGas][:properties][:type][:enum]
        result[:gastype] = @@schema[:definitions][:EnergyWindowMaterialGas][:properties][:gas_type][:default]
        result[:thickness] = @@schema[:definitions][:EnergyWindowMaterialGas][:properties][:thickness][:default]
        result
      end

      def name
        @hash[:name]
      end

      def name=(new_name)
        @hash[:name] = new_name
      end

      def find_existing_openstudio_object(openstudio_model)
        object = openstudio_model.getGasByName(@hash[:name])
        return object.get if object.is_initialized
        nil
      end

      def create_openstudio_object(openstudio_model)
        openstudio_window_gas = OpenStudio::Model::Gas.new(openstudio_model)
        openstudio_window_gas.setName(@hash[:name])
        if @hash[:thickness]
          openstudio_window_gas.setThickness(@hash[:thickness])
        else
          openstudio_window_gas.setThickness(@@schema[:EnergyWindowMaterialGas][:thickness][:default])
        end
        openstudio_window_gas.setGasType(@hash[:gas_type])
        openstudio_window_gas
      end
    end # EnergyWindowMaterialGas
  end # EnergyModel
end # Ladybug