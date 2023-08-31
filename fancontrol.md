 - sudo apt install lm-sensors fancontrol
 - sudo sensors
 - service kmod start
 - pwmconfig
 - service fancontrol start
 - sensors to view    


 FAN1  
    PWM 8 FAN 0
      PWM 255 FAN 4470

Common Settings:
INTERVAL=5

Settings of hwmon3/pwm3:
  Depends on
  Controls
  MINTEMP=
  MAXTEMP=
  MINSTART=
  MINSTOP=

Settings of hwmon3/pwm2:
  Depends on
  Controls
  MINTEMP=
  MAXTEMP=
  MINSTART=
  MINSTOP=

Settings of hwmon3/pwm1:
  Depends on hwmon2/temp1_input
  Controls
  MINTEMP=30
  MAXTEMP=85
  MINSTART=150
  MINSTOP=8
  MINPWM=0
  MAXPWM=255