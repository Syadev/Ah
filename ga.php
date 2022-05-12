<?php
error_reporting(0);
function check_valid($data){
	$data = explode('|',$data);
	$data = explode(':',$data['0']);
	$email = $data[0];
	if(!$email){
		$response = array("response"=>"unknown","message"=>"Invalid Email Input");
	}else{
		$headers = array();	
		$headers[] = 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36		';	
		$url = "https://www.paypal.com/donate?business=$email&item_name=Powerd%20by%20AlexaMP&currency_code=USD";
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
		curl_setopt($ch, CURLOPT_RETURNTRANSFER,true); 
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION,true); 
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_ENCODING, 'gzip, deflate');
		$result = curl_exec($ch);
		$xxo1 = explode('templateData" type="application/json">',$result);
		$xxo2 = explode('</script>',$xxo1[1]);
		$josn_output = json_decode($xxo2[0],true);
		if(!$result){
			$response = array("response"=>"unknown","message"=>"Unknown Response or Your IP got banned");
		}else{
			$bussinesEmail = $josn_output['donationEmail'];
			$bussinesName = $josn_output['donationName'];
			if($bussinesEmail){
				$response = array("response"=>"EMAIL_VALID","message"=>"Account detected","email"=>"$bussinesEmail","bussinesName"=>"$bussinesName");
			}else{
				$webscrErrorCode = $josn_output['webscrErrorCode'];
				if($webscrErrorCode == 'ACCOUNT_LOCKED'){
					$response = array("response"=>"EMAIL_LIMITED","message"=>"Account locked","email"=>"$email");
				}else
				if($webscrErrorCode == 'ACCOUNT_UNILATERAL'){
					$response = array("response"=>"EMAIL_UNREGISTERED","message"=>"Account Not Found","email"=>"$email");
				}else{
					$response = array("response"=>"unknown","message"=>"Unknown Response or Your IP got banned");
				}
			}
		}
	}
	return json_encode($response);
}


$email = 'support@contabo.com';
$check = check_valid($email);
echo $check;
?>
