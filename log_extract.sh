read -p "Choose job type: (e)xperiment or (w)orkspace? " job_char

read -p "Enter job slug: " SLUGZ

if [ $job_char == "e" ]; then
        jobtype="Experiment"
elif [ $job_char == "w" ]; then
        jobtype="NotebookSession"
else
        echo "please enter either 'e' or 'w'"
fi


rails runner "File.open('logfile_$SLUGZ.txt', 'w') do |fo|
$jobtype.where(slug:'$SLUGZ').last.output_chunks.where(created_at:(Time.now - 6.day)..(Time.now)).last(1000).map{|x| fo.puts x.value}
end"

echo "***********************************************"
echo "***                                         ***"
echo "***        log exported succesfully!        ***"
echo "***                                         ***"
echo "***********************************************"
echo "                                               "
echo "run this command locally to transfer the log file:"
echo "                                               "

loqation=$(pwd)

echo "scp -i ~/keys/cnvrgapp2.pem ubuntu@app.cnvrg.lightricks.com:$loqation/logfile_$SLUGZ.txt /local/target/path"
echo "                                               "
echo "                                               "
