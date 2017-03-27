import tweepy

consumer_key = "GYMBVqR7pJJYgVimhmafomtY4";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "9c8kMWgP23RWWh4tCdpuRF5kRfKvH7M3Bliqe8LTOPkDUjG2NG";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "330338366-AJAeQnh2EPUuc9abN3aa45lqhRqpocyrl7UbghQs";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "AhYI6wsL1K2u64lg0DYnZVAln3Mqh3xLZdkC6uJ9zXqji";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



