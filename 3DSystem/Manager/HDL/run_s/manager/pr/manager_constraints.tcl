#---------------------------------------------------------
# Set the expected macro and logic area to total area ratio
#   - will probably have to vary
#---------------------------------------------------------

  set CORE_UTILIZATION 0.7

  set MIN_DISTANCE_BETWEEN_MACROS 10
  set SLIVER_DISTANCE_BETWEEN_MACROS 10
  set CORE_ASPECT_RATIO 1.12
  #set CORE_ASPECT_RATIO 1.12
  #set CORE_ASPECT_RATIO 0.89
  #
  # scaling sqrt(1.95)
  #set CHIPLET_SCALING_FROM65TO28 1.39
  set CHIPLET_SCALING_FROM65TO28 1.62
  set CHIPLET_WIDTH  [expr ${CHIPLET_SCALING_FROM65TO28} * 1460.0]
  set CHIPLET_HEIGHT [expr ${CHIPLET_SCALING_FROM65TO28} * 1650.0]


  set USE_CREATE_FP_PLACEMENT "true"

  set test_route true
  set run_fill false
  set generate_parasitics true
  set generate_verilog    true


