============================================
A Yambar Keyboard Layout Module for Hyprland
============================================
---------------------------------------------------------------------------------
A simple module to show the current keyboard layout on Yambar when using Hyprland
---------------------------------------------------------------------------------

Installation Instructions
=========================
First, install `Zig <https://ziglang.org/>`_, you will use it to compile the script itself. Clone
this repository:

.. code-block:: sh

   git clone https://github.com/AmitDIRTYC0W/yambar-hyprland-kw.git

Build and install the executable itself:

.. code-block:: sh

   cd yambar-hyprland-kw
   zig build -Doptimize=ReleaseSafe -p ~/.local/

This will install the executable to ``~/.local/bin/yambar-hyprland-kw``. Ensure ``~/.local/bin`` is
in your ``PATH``.

Finally, include the script in your Yambar configuration file ``~/.config/yambar/config.yml``, for
example:

.. code-block:: yml

   bar:
     right:
       - script:
           path: ~/.local/bin/yambar-hyprland-kw
           content:
             - string:
                 text: "{layout}"

Restart Yambar, change the keyboard layout and watch it working!

