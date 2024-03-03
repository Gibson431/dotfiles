{pkgs, ...}: {
  environment.systemPackages = [pkgs.rclone];
  services.cron = {
    systemCronJobs = [
      "*/30 * * * *	main	/home/main/.local/scripts/cronjobs/rclone-cron.sh"
    ];
  };
}
