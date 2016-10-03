<?php


    // The start and end of nighttime hours
    $SETTINGS_nighttime_start = '22:00';
    $SETTINGS_nighttime_end   = '07:00';
    
    // Employees and their shifts
    $EMPLOYEES = array(
        
        '0' => array(
            'name'        => 'Bernice Lyons',
            'shift_start' => '15:15',
            'shift_end'   => '23:45'
        ),
        
        '1' => array(
            'name'        => 'Gregg Santos',
            'shift_start' => '10:00',
            'shift_end'   => '22:00'
        ),
        
        '2' => array(
            'name'        => 'Bennie Montgomery',
            'shift_start' => '22:30',
            'shift_end'   => '08:00'
        ),
        
        '3' => array(
            'name'        => 'Nelson Austin',
            'shift_start' => '20:00',
            'shift_end'   => '10:00'
        ),
        
        '4' => array(
            'name'        => 'Garrett Sims',
            'shift_start' => '09:00',
            'shift_end'   => '17:00'
        ),
        
        '5' => array(
            'name'        => 'Joanna Pratt',
            'shift_start' => '23:00',
            'shift_end'   => '06:00'
        )
        /**
        '1' => array(
            'name'        => 'Joanna Pratt',
            'shift_start' => '23:00',
            'shift_end'   => '12:00'
        )**/       
    );
    
 class WorkTimeCalc{

      /**
       * construct workTime Calculator
       * @param integer $startTime Day worktime start
       * @param integer $endtime   Day worktime end
       */
      function __construct($startTime = 8 , $endtime = 18) {
        $this->startTime = $this->hoursToDecimal($startTime);
        $this->endTime   = $this->hoursToDecimal($endtime);

        $this->dayLenght = $this->endTime - $this->startTime;
        $this->nightLenght = 24 - $this->dayLenght;
      }

      /**
       * DayTime - in what process we are Now :P
       */
      private $dayTime = true;
      /**
       * DayHour param
       * @var integer
       */
      private $dayHours = 0;

      /**
       * NightHour param
       * @var integer
       */
      private $nightHours = 0;

      /**
       * Total Shift hours for return
       * @var integer
       */
      private $totalShiftHours = 0;


      /**
       * if end time is before startime - it is next Day (+24 hours)
       * @return NULL
       */
      private function refactorShiftEnd(){
        $this->shiftEnd += 24;
      }

      /**
       * Set Value of DayHours
       * @param Integer $hours time in hours
       */
      private function setDayHours($hours){
        $this->dayHours = $hours;
      }

      /**
       * Get Day Hours
       * @return Integer Spent time in hours
       */
      public function getDayHours(){
        return $this->dayHours;
      }

    /**
     * Increase Day Hours
     * @param  Integer $hours Time to increase in Hours
     * @return NULL
     */
      private function increaseDayHours($hours){
        $this->setDayHours($this->getDayHours() + $hours);
      }

      /**
       * Set Value of NightHours
       * @param [type] $hours [description]
       */
      private function setNightHours($hours){
        $this->nightHours = $hours;
      }

      /**
       * Get Night Hours
       * @return Integer Spent time in hours
       */
      public function getNightHours(){
        return $this->nightHours;
      }

    /**
     * Increase Night Hours
     * @param  Integer $hours Time to increase in Hours
     * @return NULL
     */
      private function increaseNightHours($hours){
        $this->setNightHours($this->getNightHours() + $hours);
      }

      /**
       * Convert Time to number
       * @param  Mixed $time Time in any format
       * @return Decimal       Time in number
       */
      private function hoursToDecimal($time , $full = false){

          $return = array(
                'time' => $time ,
                'minutes' => 0 ,
                'number' => 0 
          );

          if (strpos($time, ':') > -1){
            $explodedTime = explode(":", $time);
            $return['time'] = $explodedTime[0];
            $minutes = (intval($explodedTime[1] / 15) * 15);

            $return['minutes'] = $minutes;
            $return['number'] = ($minutes / 60 );

            $return['time'] += $return['number'];
          }

          if ($full){
            return $return;
          }

          return $return['time'];
      }

      /**
       * Calculate Night hours to Update total Day Hours
       * @param  boolean $unlisted_hours Hours that will be added , and does not change Index
       * @return NULL
       */
      private function calculateNight($hours = false){

        $nightLenght = $hours;

        if (!$hours){
            $nightLenght = $this->nightLenght;
        }

        if ($this->shiftLenght >= $nightLenght){
            $this->increaseNightHours($nightLenght);
            $this->shiftLenght -= $nightLenght;
        }else{
            $lastNightLength = $nightLenght + ($this->shiftLenght - $nightLenght);
            $this->increaseNightHours($lastNightLength);
            $this->shiftLenght = 0;
        }

      }

      /**
       * Calculate Day hours to Update total Day Hours
       * @param  boolean $unlisted_hours [description]
       * @return [type]                  [description]
       */
      private function calculateDay($unlisted_hours = false){

        $dayLenght = $unlisted_hours;

        if (!$unlisted_hours){
            $dayLenght = $this->dayLenght;
        }

        if ($this->shiftLenght >= $dayLenght){
            $this->increaseDayHours($dayLenght);
            $this->shiftLenght = $this->shiftLenght - $dayLenght;
        }else{
            $lastDayLength = $dayLenght + ($this->shiftLenght - $dayLenght);
            $this->increaseDayHours($lastDayLength);
            $this->shiftLenght = 0;
        }   
      }

      /**
       * Parse out Shift Hours
       * @return NULL
       */
      public function parseShiftHours(){
        
        if ($this->shiftStartIndex < 0){

            $nightHours = ($this->nightLenght - ($this->nightLenght + $this->shiftStartIndex));

            $this->calculateNight(
                ($this->nightLenght - $nightHours)
            );
        }else if ($this->shiftStartIndex > 0 ){

            $dayHours = ($this->dayLenght - $this->shiftStartIndex);

            if ($dayHours < 0){
                $nightHours = ($this->nightLenght - ($this->nightLenght + $dayHours));
                $totalNight = ($this->nightLenght - $nightHours);

                $this->calculateNight( $totalNight);

            }else{
                $this->calculateDay( $dayHours );
                $this->dayTime = false;
            }
        }

        while ($this->shiftLenght > 0){

            if ($this->dayTime){
                $this->calculateDay();
            }else{
                $this->calculateNight();
            }

            $this->dayTime = !$this->dayTime;
        }

      }

      /**
       * Return total Shift Lenght
       * @return number Lenght in number
       */
      public function getShiftLenght(){
          return $this->totalShiftHours;
      }

      /**
       * Get Shift Start time Decimal
       * @return number Start time in Decimal number
       */
      public function getShiftStart(){
          return $this->shiftStart;  
      }

      /**
       * Get Shift End
       * @return number Start time in Decimal number
       */
      public function getShiftEnd(){
          $shiftEnd = $this->shiftEnd;

          //darn - workAround
          if ($shiftEnd > 24){
            $shiftEnd -= 24;
          }

          return $this->shiftEnd;
      }

      /**
       * Set Shift Day and Night Hours
       * @param  Integer $startTime Work start time
       * @param  Integer $endTime   Work End time
       * @return Object            This object
       */
      public function setShiftHours($shiftStartTime , $shiftEndTime , $parse = true){

          //define time params
          $this->shiftStart = $this->hoursToDecimal($shiftStartTime);
          $this->shiftEnd = $this->hoursToDecimal($shiftEndTime);

          $this->dayHours = 0;
          $this->nightHours = 0;

          /**
           * Alternative calc taking 48 h range :
           * 0 is start of first day 48 end of second
           **/

          if ($this->shiftStart > $this->shiftEnd){
              $this->refactorShiftEnd();
          }

          $this->shiftStartIndex = $this->shiftStart - $this->startTime;

          $this->shiftLenght = $this->shiftEnd - $this->shiftStart;

          $this->totalShiftHours = $this->shiftLenght;

          if ($parse){
            $this->parseShiftHours();   
          }    
      }
  }

  $workTime = new WorkTimeCalc($SETTINGS_nighttime_end , $SETTINGS_nighttime_start);

  $allEmployeeData = array();

  foreach ($EMPLOYEES as $key => $employee) {
    
    $workTime->setShiftHours($employee['shift_start'] , $employee['shift_end']);

    $employeeArray = array(
        $employee['name'],
        $employee['shift_start'].' ('.$workTime->getShiftStart().')',
        $employee['shift_end'].' ('.$workTime->getShiftEnd().')',
        $workTime->getShiftLenght(),
        $workTime->getDayHours(),
        $workTime->getNightHours()
    );

    $allEmployeeData[] = '<tr><td>'.implode($employeeArray , "</td>/n<td>").'</td></tr>';
  }

?>

<table width="100%">
    <tr>
        <th>Name</th>
        <th>Shift Start</th>
        <th>Shift End</th>
        <th>Lenght</th>
        <th>DayHours</th>
        <th>NightHours</th>
    </tr>
    <?= implode($allEmployeeData , "\n" ) ?>
</table>