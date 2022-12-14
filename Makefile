# SPDX-FileCopyrightText: 2021 Uri Shaked
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

TARGETS = gds/skullart.gds gds/skullart.lef

all: gds $(TARGETS)
clean: 
	rm -f $(TARGETS)

.PHONY: all clean

magic_skullart: src/skullart.mag
	magic -rcfile $(PDK_ROOT)/sky130A/libs.tech/magic/sky130A.magicrc $<

gds:
	mkdir -p gds

gds/skullart.gds: src/skullart.mag
	echo "select visible\nupsidedown\nsideways\ngds write \"$@\"" | magic -rcfile $(PDK_ROOT)/sky130A/libs.tech/magic/sky130A.magicrc -noconsole -dnull $<

gds/skullart.lef: src/skullart.mag
	echo "select visible\nupsidedown\nsideways\nlef write \"$@\"" | magic -rcfile $(PDK_ROOT)/sky130A/libs.tech/magic/sky130A.magicrc -noconsole -dnull $<