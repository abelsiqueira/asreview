# Copyright 2019-2023 The ASReview Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import argparse
import functools
import warnings


def _deprecated_func(msg):
    def dec(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            warnings.warn(msg)
            return func(*args, **kwargs)

        return wrapper

    return dec


class DeprecateAction(argparse.Action):
    def __call__(self, parser, namespace, values, option_string=None):
        warnings.warn(f"Argument {self.option_strings} is deprecated and is ignored.")
        delattr(namespace, self.dest)
