variable  "billing_threshold" {

    description= "the value of the billing limites "
    default= 50

}

variable "email_alert" {

    description= "the email where the notification billing is sent"
    sensitive= true
    type= string
    

}

